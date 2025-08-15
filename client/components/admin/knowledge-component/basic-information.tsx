"use client"

import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Label } from "@/components/ui/label"
import { BookOpen } from "lucide-react"

interface BasicInformationProps {
  name: string
  description: string
  onNameChange: (value: string) => void
  onDescriptionChange: (value: string) => void
  error?: string | null
}

export function BasicInformation({ 
  name, 
  description, 
  onNameChange, 
  onDescriptionChange, 
  error 
}: BasicInformationProps) {
  return (
    <div className="mb-12">
      <div className="space-y-5">
        <div className="space-y-5">
          <div className="space-y-2">
            <Label htmlFor="kc-name" className="text-sm font-medium text-gray-700">Name</Label>
            <Input
              id="kc-name"
              value={name}
              onChange={(e) => onNameChange(e.target.value)}
              placeholder="Enter KC name"
              className={`h-11 border-gray-200 focus:border-blue-500 focus:ring-blue-500 text-gray-900 placeholder:text-gray-400 ${
                error && !name.trim() ? 'border-red-300 focus:border-red-500 focus:ring-red-500' : ''
              }`}
            />
            {error && !name.trim() && (
              <p className="text-red-500 text-xs">Knowledge Component name is required</p>
            )}
          </div>
          <div className="space-y-2">
            <Label htmlFor="kc-description" className="text-sm font-medium text-gray-700">Description</Label>
            <Textarea
              id="kc-description"
              value={description}
              onChange={(e) => onDescriptionChange(e.target.value)}
              placeholder="Enter description"
              rows={4}
              className="border-gray-200 focus:border-blue-500 focus:ring-blue-500 text-gray-900 placeholder:text-gray-400"
            />
          </div>
        </div>
      </div>
    </div>
  )
}
