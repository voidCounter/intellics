"use client"

import * as React from "react"
import {
  ColumnDef,
  ColumnFiltersState,
  SortingState,
  VisibilityState,
  flexRender,
  getCoreRowModel,
  getFacetedRowModel,
  getFacetedUniqueValues,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useReactTable,
  ColumnResizeMode,
} from "@tanstack/react-table"

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"

import { DataTablePagination } from "./data-table-pagination"
import { DataTableColumnFilter } from "./data-table-column-filter"

interface DataTableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[]
  data: TData[]
  searchKey?: string
  searchPlaceholder?: string
  showPagination?: boolean
  showToolbar?: boolean
  tableId?: string
  onSelectionChange?: (selectedRows: TData[]) => void
  onClearSelection?: () => void
}

export function DataTable<TData, TValue>({
  columns,
  data,
  searchKey,
  searchPlaceholder = "Search...",
  showPagination = true,
  showToolbar = true,
  tableId = "default",
  onSelectionChange,
  onClearSelection,
}: DataTableProps<TData, TValue>) {
  const [rowSelection, setRowSelection] = React.useState({})
  const [columnVisibility, setColumnVisibility] = React.useState<VisibilityState>({})
  const [columnFilters, setColumnFilters] = React.useState<ColumnFiltersState>([])
  const [sorting, setSorting] = React.useState<SortingState>([])
  
  // Initialize column sizing from localStorage with fallback to empty object
  const [columnSizing, setColumnSizing] = React.useState(() => {
    if (typeof window !== 'undefined') {
      const saved = localStorage.getItem(`table-column-sizes-${tableId}`);
      return saved ? JSON.parse(saved) : {};
    }
    return {};
  });
  
  const [pagination, setPagination] = React.useState({
    pageIndex: 0,
    pageSize: 20,
  })

  // Save column sizes to localStorage whenever they change
  React.useEffect(() => {
    if (typeof window !== 'undefined' && Object.keys(columnSizing).length > 0) {
      localStorage.setItem(`table-column-sizes-${tableId}`, JSON.stringify(columnSizing));
    }
  }, [columnSizing, tableId]);

  const table = useReactTable({
    data,
    columns,
    state: {
      sorting,
      columnVisibility,
      rowSelection,
      columnFilters,
      columnSizing,
      pagination,
    },
    enableRowSelection: true,
    enableColumnFilters: true,
    enableColumnResizing: true,
    columnResizeMode: 'onChange' as ColumnResizeMode,
    onRowSelectionChange: setRowSelection,
    onSortingChange: setSorting,
    onColumnFiltersChange: setColumnFilters,
    onColumnVisibilityChange: setColumnVisibility,
    onColumnSizingChange: setColumnSizing,
    onPaginationChange: setPagination,
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFacetedRowModel: getFacetedRowModel(),
    getFacetedUniqueValues: getFacetedUniqueValues(),
  })

  // Call onSelectionChange when selection changes
  React.useEffect(() => {
    if (onSelectionChange) {
      const selectedRows = table.getFilteredSelectedRowModel().rows.map(row => row.original);
      onSelectionChange(selectedRows);
    }
  }, [rowSelection, onSelectionChange, table]);

  // Handle clear selection request
  React.useEffect(() => {
    if (onClearSelection) {
      const clearSelection = () => {
        setRowSelection({});
      };
      
      // Store the clear function in a way that parent can call it
      (window as any).__clearTableSelection = clearSelection;
      
      return () => {
        delete (window as any).__clearTableSelection;
      };
    }
  }, [onClearSelection]);

  return (
    <div className="space-y-4">
      {showToolbar && (
        <div className="flex items-center justify-between">
          <div className="flex flex-1 items-center space-x-2">
            {searchKey && (
              <input
                placeholder={searchPlaceholder}
                value={(table.getColumn(searchKey)?.getFilterValue() as string) ?? ""}
                onChange={(event) =>
                  table.getColumn(searchKey)?.setFilterValue(event.target.value)
                }
                className="max-w-sm px-3 py-2 border border-input bg-background rounded-md text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
              />
            )}
            {table.getAllColumns()
              .filter((column) => column.getCanFilter())
              .map((column) => (
                <DataTableColumnFilter
                  key={column.id}
                  column={column}
                  table={table}
                />
              ))}
          </div>
        </div>
      )}
      <div className="rounded-md border">
        <div 
          className="overflow-x-auto overflow-y-hidden isolate" 
          style={{ 
            scrollbarWidth: 'thin', 
            scrollbarColor: 'rgb(156 163 175) transparent',
            overscrollBehavior: 'contain'
          }}
        >
          <Table style={{ width: table.getCenterTotalSize() }}>
            <TableHeader>
              {table.getHeaderGroups().map((headerGroup) => (
                <TableRow key={headerGroup.id}>
                  {headerGroup.headers.map((header) => {
                    return (
                      <TableHead 
                        key={header.id} 
                        colSpan={header.colSpan} 
                        className="whitespace-nowrap relative"
                        style={{ width: header.getSize() }}
                      >
                        {header.isPlaceholder
                          ? null
                          : flexRender(
                              header.column.columnDef.header,
                              header.getContext()
                            )}
                        {header.column.getCanResize() && (
                          <div
                            onMouseDown={header.getResizeHandler()}
                            onTouchStart={header.getResizeHandler()}
                            className={`absolute right-0 top-0 h-full w-1 cursor-col-resize select-none touch-none ${
                              header.column.getIsResizing() 
                                ? 'bg-blue-500' 
                                : 'bg-transparent hover:bg-gray-300'
                            }`}
                          >
                            {/* Visual marker for resize handle */}
                            <div className="absolute right-0 top-1/2 -translate-y-1/2 w-1 h-6 bg-gray-300 opacity-40 rounded-full" />
                          </div>
                        )}
                      </TableHead>
                    )
                  })}
                </TableRow>
              ))}
            </TableHeader>
            <TableBody>
              {table.getRowModel().rows?.length ? (
                table.getRowModel().rows.map((row) => (
                  <TableRow
                    key={row.id}
                    data-state={row.getIsSelected() && "selected"}
                    className={`group relative md:cursor-pointer md:hover:bg-muted/50 ${
                      row.getIsSelected() ? 'bg-blue-50 border-l-4 border-l-blue-500' : ''
                    }`}
                  >
                    {row.getVisibleCells().map((cell) => (
                      <TableCell 
                        key={cell.id}
                        style={{ width: cell.column.getSize() }}
                      >
                        {flexRender(
                          cell.column.columnDef.cell,
                          cell.getContext()
                        )}
                      </TableCell>
                    ))}
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell
                    colSpan={columns.length}
                    className="h-24 text-center"
                  >
                    No results.
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </div>
      </div>
      {showPagination && <DataTablePagination table={table} />}
    </div>
  )
}
