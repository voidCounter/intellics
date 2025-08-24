'use client';

import { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button } from '@/components/ui/button';
import { 
  Dialog, 
  DialogContent, 
  DialogDescription, 
  DialogFooter, 
  DialogHeader, 
  DialogTitle, 
  DialogTrigger,
  DialogClose
} from '@/components/ui/dialog';
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { toast } from 'sonner';
import { Module } from '@/types/api';

import { logger } from '@/lib/utils';
const createModuleSchema = z.object({
  module_name: z.string().min(1, 'Module name is required').max(255, 'Module name cannot exceed 255 characters'),
  description: z.string().max(1000, 'Description cannot exceed 1000 characters').optional(),
});

type CreateModuleFormData = z.infer<typeof createModuleSchema>;

interface CreateModuleDialogProps {
  onModuleCreated: () => void;
  onModuleUpdated: () => void;
  onClose?: () => void;
  module?: Module | null;
  mode?: 'create' | 'edit';
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

export function CreateModuleDialog({ 
  onModuleCreated, 
  onModuleUpdated, 
  module, 
  mode = 'create',
  open: propOpen,
  onOpenChange: propOnOpenChange,
  onClose: propOnClose,
}: CreateModuleDialogProps) {
  const [open, setOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<CreateModuleFormData>({
    resolver: zodResolver(createModuleSchema),
    defaultValues: {
      module_name: '',
      description: '',
    },
  });

  // Update form when module prop changes (for edit mode)
  useEffect(() => {
    if (module && mode === 'edit') {
      form.reset({
        module_name: module.module_name,
        description: module.description || '',
      });
    } else if (mode === 'create') {
      form.reset({
        module_name: '',
        description: '',
      });
    }
  }, [module, mode, form]);

  const onSubmit = async (data: CreateModuleFormData) => {
    try {
      setIsSubmitting(true);
      
      const token = localStorage.getItem('authToken');
      if (!token) {
        toast.error('Authentication required');
        return;
      }

      if (mode === 'edit' && module) {
        // Update existing module
        const response = await fetch('/api/modules', {
          method: 'PUT',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            module_id: module.module_id,
            ...data,
          }),
        });

        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}));
          throw new Error(errorData.message || 'Failed to update module');
        }

        const result = await response.json();
        if (result.status === 'SUCCESS') {
          toast.success('Module updated successfully');
          form.reset();
          setOpen(false);
          onModuleUpdated();
        } else {
          throw new Error(result.message || 'Failed to update module');
        }
      } else {
        // Create new module
        const response = await fetch('/api/modules', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(data),
        });

        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}));
          throw new Error(errorData.message || 'Failed to create module');
        }

        const result = await response.json();
        if (result.status === 'SUCCESS') {
          toast.success('Module created successfully');
          form.reset();
          setOpen(false);
          onModuleCreated();
        } else {
          throw new Error(result.message || 'Failed to create module');
        }
      }
    } catch (error) {
      logger.error(`Error ${mode === 'edit' ? 'updating' : 'creating'} module:`, error);
      toast.error(error instanceof Error ? error.message : `Failed to ${mode === 'edit' ? 'update' : 'create'} module`);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleOpenChange = (newOpen: boolean) => {
    if (!newOpen) {
      form.reset();
      if (mode === 'edit') {
        propOnClose?.();
      }
    }
    setOpen(newOpen);
    propOnOpenChange?.(newOpen);
  };

  const isOpen = propOpen ?? open;
  const handleOpenChangeForEdit = (newOpen: boolean) => {
    if (mode === 'edit') {
      propOnOpenChange?.(newOpen);
      return;
    }
    handleOpenChange(newOpen);
  };

  const dialogTitle = mode === 'edit' ? 'Edit Module' : 'Create New Module';
  const dialogDescription = mode === 'edit' 
    ? 'Update the module details below.' 
    : 'Create a new learning module. Fill in the details below.';
  const submitButtonText = isSubmitting 
    ? (mode === 'edit' ? 'Updating...' : 'Creating...') 
    : (mode === 'edit' ? 'Update Module' : 'Create Module');

  return (
    <Dialog open={isOpen} onOpenChange={handleOpenChangeForEdit}>
      {mode === 'create' && (
        <DialogTrigger asChild>
          <Button 
            className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
            onClick={() => handleOpenChange(true)}
          >
            Create Module
          </Button>
        </DialogTrigger>
      )}
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{dialogTitle}</DialogTitle>
          <DialogDescription>
            {dialogDescription}
          </DialogDescription>
        </DialogHeader>
        
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="module_name"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Module Name *</FormLabel>
                  <FormControl>
                    <Input placeholder="Enter module name" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            
            <FormField
              control={form.control}
              name="description"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Description</FormLabel>
                  <FormControl>
                    <Textarea 
                      placeholder="Enter module description (optional)"
                      className="min-h-[3rem]"
                      {...field} 
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            
            <DialogFooter>
              <DialogClose asChild>
                <Button
                  type="button"
                  variant="outline"
                  disabled={isSubmitting}
                >
                  Cancel
                </Button>
              </DialogClose>
              <Button type="submit" disabled={isSubmitting}>
                {submitButtonText}
              </Button>
            </DialogFooter>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
