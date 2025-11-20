namespace ChilternGlobalBC.ChilternGlobalBC;

codeunit 50201 "Product Hierarchy Mgt"
{

    procedure EnsureProductType(var ProductTypeCode: Code[20])
    var
        ProductType: Record "Product Type";
    begin
        if ProductTypeCode = '' then
            exit;

        if not ProductType.Get(ProductTypeCode) then begin
            if Confirm('Product Type %1 does not exist. Do you want to create it?', false, ProductTypeCode) then begin
                ProductType.Init();
                ProductType."Product Type Code" := ProductTypeCode;
                ProductType.Description := ProductTypeCode;
                ProductType.Insert();
            end else begin
                ProductTypeCode := ''; // reset to blank if declined
            end;
        end;
    end;

    procedure EnsureProductCategory(var CategoryCode: Code[20]; ProductTypeCode: Code[20])
    var
        Category: Record "Product Category";
    begin
        if CategoryCode = '' then
            exit;

        if not Category.Get(CategoryCode) then begin
            if Confirm('Product Category %1 does not exist. Do you want to create it?', false, CategoryCode) then begin
                Category.Init();
                Category."Product Category Code" := CategoryCode;
                Category."Product Type Code" := ProductTypeCode;
                Category.Description := CategoryCode;
                Category.Insert();
            end else begin
                CategoryCode := ''; // reset to blank if declined
            end;
        end;
    end;

    procedure EnsureProductGroup(var GroupCode: Code[20]; CategoryCode: Code[20])
    var
        Group: Record "Product Group";
    begin
        if GroupCode = '' then
            exit;

        if not Group.Get(GroupCode) then begin
            if Confirm('Product Group %1 does not exist. Do you want to create it?', false, GroupCode) then begin
                Group.Init();
                Group."Product Group Code" := GroupCode;
                Group."Product Category Code" := CategoryCode;
                Group.Description := GroupCode;
                Group.Insert();
            end else begin
                GroupCode := ''; // reset to blank if declined
            end;
        end;
    end;

    procedure EnsureProductRange(var RangeCode: Code[20]; GroupCode: Code[20])
    var
        Range: Record "Product Range";
    begin
        if RangeCode = '' then
            exit;

        if not Range.Get(RangeCode) then begin
            if Confirm('Product Range %1 does not exist. Do you want to create it?', false, RangeCode) then begin
                Range.Init();
                Range."Product Range Code" := RangeCode;
                Range."Product Group Code" := GroupCode;
                Range.Description := RangeCode;
                Range.Insert();
            end else begin
                RangeCode := ''; // reset to blank if declined
            end;
        end;
    end;
}
