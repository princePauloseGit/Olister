# Item Variants Management System - User Guide

## Overview
This system allows you to create multiple Item Variants based on combinations of Size, Color, and Material attributes. The variants are automatically saved to the standard Business Central **Item Variant (5401)** table with extended fields for tracking attributes.

## Tables Created
1. **Item Size** (Table 50245) - Master data for sizes (e.g., X, XL, XXL)
2. **Item Color** (Table 50246) - Master data for colors (e.g., Red, Green, Blue)
3. **Item Material** (Table 50247) - Master data for materials (e.g., Cotton, Polyester, Leather)
4. **Item Attribute Combination** (Table 50248) - Links items with their attribute combinations
5. **Item Variant Extension** (Table Ext 50245) - Extends standard Item Variant table with Size, Color, and Material fields

## Pages Created
1. **Item Sizes** (Page 50260) - Manage size master data
2. **Item Colors** (Page 50271) - Manage color master data
3. **Item Materials** (Page 50272) - Manage material master data
4. **Item Attribute Combinations** (Page 50248) - View and manage all attribute combinations
5. **Item Attribute Combination Card** (Page 50273) - Create/edit individual combinations
6. **Item Variant Card Extension** (Page Ext 50245) - Shows Size, Color, Material on variant card
7. **Item Variants Extension** (Page Ext 50246) - Shows Size, Color, Material columns on variant list

## How to Use

### Step 1: Set Up Master Data
1. Open **Item Sizes** page and create your sizes:
   - Code: X, Description: Extra Small
   - Code: XL, Description: Extra Large
   - etc.

2. Open **Item Colors** page and create your colors:
   - Code: RED, Description: Red
   - Code: GREEN, Description: Green
   - etc.

3. Open **Item Materials** page and create your materials:
   - Code: COTTON, Description: Cotton
   - Code: POLY, Description: Polyester
   - etc.

### Step 2: Create Attribute Combinations
1. Open **Item Attribute Combinations** page
2. Click **New** to create a new combination
3. Select the **Item No.** (e.g., Item1)
4. Select the **Size Code** (e.g., X)
5. Select the **Color Code** (e.g., RED)
6. Optionally select **Material Code**
7. Save the record

### Step 3: Automatic Variant Creation
When you save an attribute combination:
- The system automatically creates an **Item Variant** in the standard BC Item Variant table (5401)
- The variant code is generated as: SIZE-COLOR-MATERIAL (e.g., X-RED, XL-GREEN)
- The variant description is generated from the attribute descriptions
- Size Code, Color Code, and Material Code are stored in the Item Variant record

### Step 4: View Variants
You can view the created variants in two ways:
1. **From Item Attribute Combinations page:** Use the "View Item Variant" action
2. **From Item Card:** Go to Navigate > Variants to see all variants with their attributes

## Example Scenarios

### Example 1: Item1 with Size and Color
**Item:** Item1  
**Combinations:**
1. Item1 + Size=X + Color=RED → Creates Variant: "X-RED" in Item Variant table
2. Item1 + Size=X + Color=GREEN → Creates Variant: "X-GREEN" in Item Variant table
3. Item1 + Size=XL + Color=RED → Creates Variant: "XL-RED" in Item Variant table
4. Item1 + Size=XL + Color=GREEN → Creates Variant: "XL-GREEN" in Item Variant table

All variants are saved in the standard **Item Variant (5401)** table and can be used throughout Business Central.

### Example 2: Item1 with All Attributes
**Item:** Item1  
**Combinations:**
1. Item1 + Size=X + Color=RED + Material=COTTON → Creates Variant: "X-RED-COTT"
2. Item1 + Size=XL + Color=GREEN + Material=POLY → Creates Variant: "XL-GREEN-P"

## Features

### Automatic Variant Generation
- Variants are created automatically when you save an attribute combination
- Variants are saved to the standard Business Central Item Variant table (5401)
- Variant codes are generated based on the attribute codes
- Variant descriptions combine all attribute descriptions
- Size, Color, and Material codes are stored in the variant record

### Extended Item Variant Table
The standard Item Variant table now includes:
- **Size Code** - Links to Item Size master
- **Color Code** - Links to Item Color master  
- **Material Code** - Links to Item Material master
- **Size Description** - FlowField showing size description
- **Color Description** - FlowField showing color description
- **Material Description** - FlowField showing material description

### Enhanced Item Variant Pages
- **Item Variant Card** - Shows an "Attribute Details" section with size, color, and material
- **Item Variants List** - Shows Size Code, Color Code, and Material Code columns

### View Created Variants
- From the **Item Attribute Combinations** page, use the **View Item Variant** action
- This opens the standard Item Variant card showing all details including attributes

### View Item
- Use the **View Item** action to navigate to the item card

### FlowFields
- Size Description, Color Description, Material Description are automatically displayed
- Item Description shows the base item name

## Integration with Business Central

### Standard BC Integration
Since variants are saved to the standard Item Variant table, they work seamlessly with:
- Sales Orders - Select variant when adding line items
- Purchase Orders - Order specific variants
- Inventory Management - Track stock by variant
- Pricing - Set prices per variant
- Planning - Plan by variant
- All standard BC processes that use variants

## Notes
- You can use any combination of Size, Color, or Material (not all are required)
- Each unique combination creates a separate variant in the standard Item Variant table
- Variant codes are limited to 10 characters, so long attribute codes may be truncated
- The system prevents duplicate variants for the same attribute combination
- If a variant already exists, the system updates it with the attribute codes

## Troubleshooting

### Variant Not Created
If a variant is not created:
1. Check that the Item No. exists and is valid
2. Ensure at least one attribute (Size, Color, or Material) is selected
3. Check if a variant with the same code already exists (it will be updated instead)
4. Review any error messages displayed

### Duplicate Variant Codes
If you get duplicate variant code errors:
- The system prevents duplicates automatically
- Shorten your attribute codes if they exceed 10 characters combined
- Existing variants will be updated with new attribute information

## Navigation
All pages are available in the **Lists** section of Business Central.
