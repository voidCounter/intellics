"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Plus } from "lucide-react"
import { useCreateKnowledgeComponent } from "@/hooks/useKnowledgeComponent"
import { toast } from "sonner"

interface CreateKCDialogProps {
  onSuccess?: () => void
}

export function CreateKCDialog({ onSuccess }: CreateKCDialogProps) {
  const [open, setOpen] = useState(false)
  const [kcName, setKcName] = useState("")
  const [description, setDescription] = useState("")
  
  const createKCMutation = useCreateKnowledgeComponent()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    
    if (!kcName.trim()) {
      toast.error("Knowledge Component name is required")
      return
    }

    try {
      await createKCMutation.mutateAsync({
        kc_name: kcName.trim(),
        description: description.trim() || undefined,
      })
      
      toast.success("Knowledge Component created successfully!")
      setOpen(false)
      resetForm()
      onSuccess?.()
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Failed to create knowledge component")
    }
  }

  const resetForm = () => {
    setKcName("")
    setDescription("")
  }

  const handleOpenChange = (newOpen: boolean) => {
    setOpen(newOpen)
    if (!newOpen) {
      resetForm()
    }
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button className="border-foreground">
          <Plus className="h-4 w-4 mr-2" />
          Create KC
        </Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Create Knowledge Component</DialogTitle>
          <DialogDescription>
            Add a new knowledge component to the system. Fill in the details below.
          </DialogDescription>
        </DialogHeader>
        <form onSubmit={handleSubmit}>
          <div className="grid gap-4 py-4">
            <div className="grid gap-3">
              <Label htmlFor="kc-name">Name *</Label>
              <Input
                id="kc-name"
                value={kcName}
                onChange={(e) => setKcName(e.target.value)}
                placeholder="Enter KC name"
                maxLength={255}
                required
              />
            </div>
            <div className="grid gap-3">
              <Label htmlFor="description">Description</Label>
              <Textarea
                id="description"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                placeholder="Enter description (optional)"
                maxLength={1000}
                rows={3}
              />
            </div>
          </div>
          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => setOpen(false)}
              disabled={createKCMutation.isPending}
            >
              Cancel
            </Button>
            <Button
              type="submit"
              disabled={createKCMutation.isPending || !kcName.trim()}
            >
              {createKCMutation.isPending ? "Creating..." : "Create KC"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
