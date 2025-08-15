"use client"

import * as React from "react"
import { Column, Table } from "@tanstack/react-table"
import { Check, PlusCircle } from "lucide-react"

import { cn } from "@/lib/utils"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover"

interface DataTableColumnFilterProps<TData, TValue> {
  column?: Column<TData, TValue>
  table?: Table<TData>
}

export function DataTableColumnFilter<TData, TValue>({
  column,
  table,
}: DataTableColumnFilterProps<TData, TValue>) {
  const facets = column?.getFacetedUniqueValues()
  const selectedValues = new Set(column?.getFilterValue() as string[])

  // Extract individual values from comma-separated strings for filtering
  const extractIndividualValues = (facets: Map<string, number>) => {
    const individualValues = new Map<string, number>()
    
    facets.forEach((count, value) => {
      if (value === "None") {
        individualValues.set(value, count)
      } else {
        // Split comma-separated values and add each individually
        const items = value.split(", ").map(item => item.trim()).filter(item => item)
        items.forEach(item => {
          const existingCount = individualValues.get(item) || 0
          individualValues.set(item, existingCount + count)
        })
      }
    })
    
    return individualValues
  }

  const individualFacets = facets ? extractIndividualValues(facets) : new Map()

  const handleFilterChange = (value: string) => {
    if (selectedValues.has(value)) {
      selectedValues.delete(value)
    } else {
      selectedValues.add(value)
    }
    const filterValues = Array.from(selectedValues)
    column?.setFilterValue(filterValues.length ? filterValues : undefined)
  }

  const handleSelectAll = () => {
    if (individualFacets) {
      const allValues = Array.from(individualFacets.keys())
      column?.setFilterValue(allValues)
    }
  }

  const handleClearAll = () => {
    column?.setFilterValue(undefined)
  }

  if (!facets || facets.size === 0) {
    return null
  }

  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button variant="outline" size="sm" className="h-8 border-dashed">
          <PlusCircle className="mr-2 h-4 w-4" />
          {column?.id}
          {selectedValues.size > 0 && (
            <Badge
              variant="secondary"
              className="rounded-sm px-1 font-normal lg:hidden"
            >
              {selectedValues.size}
            </Badge>
          )}
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-[200px] p-0" align="start">
        <Command>
          <CommandInput placeholder={column?.id} />
          <CommandList>
            <CommandEmpty>No results found.</CommandEmpty>
            <CommandGroup>
              {Array.from(individualFacets.entries()).map(([value, count]) => {
                // Skip empty strings and null values
                if (!value || value === "") {
                  return null
                }
                
                const isSelected = selectedValues.has(value)
                const key = typeof value === 'string' ? value : JSON.stringify(value)
                return (
                  <CommandItem
                    key={key}
                    onSelect={() => handleFilterChange(value)}
                  >
                    <div
                      className={cn(
                        "mr-2 flex h-4 w-4 items-center justify-center rounded-sm border border-primary",
                        isSelected
                          ? "bg-primary text-primary-foreground"
                          : "opacity-50 [&_svg]:invisible"
                      )}
                    >
                      <Check className={cn("h-4 w-4")} />
                    </div>
                    <span>{String(value)}</span>
                    <Badge variant="secondary" className="ml-auto">
                      {count}
                    </Badge>
                  </CommandItem>
                )
              })}
            </CommandGroup>
            {selectedValues.size > 0 && (
              <>
                <CommandSeparator />
                <CommandGroup>
                  <CommandItem
                    onSelect={handleSelectAll}
                    className="justify-center text-center"
                  >
                    Select All
                  </CommandItem>
                  <CommandItem
                    onSelect={handleClearAll}
                    className="justify-center text-center"
                  >
                    Clear All
                  </CommandItem>
                </CommandGroup>
              </>
            )}
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  )
}
