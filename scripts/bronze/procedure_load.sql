create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime ;
begin try
print '=============================';
print 'Loading bronze layer';
print '=============================';

print '-----------------------------------';
print'loading crm tables';
print '-----------------------------------';

set @start_time = getdate();
print 'Truncating table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info;
print 'Inserting table: bronze.crm_cust_info';
bulk insert bronze.crm_cust_info
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';


set @start_time = getdate();
print 'Truncating table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info;
print 'Inserting table: bronze.crm_prd_info';
bulk insert bronze.crm_prd_info
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';


set @start_time = getdate();
print 'Truncating table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
print 'Inserting table: bronze.crm_sales_details';
bulk insert bronze.crm_sales_details
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';





print '-----------------------------------';
print'loading erp tables';
print '-----------------------------------';

set @start_time = getdate();
print 'Truncating table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;
print 'Inserting table: bronze.erp_cust_az12';
bulk insert bronze.erp_cust_az12
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';

set @start_time = getdate();
print 'Truncating table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;
print 'Inserting table: bronze.erp_loc_a101';
bulk insert bronze.erp_loc_a101
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';

set @start_time = getdate();
print 'Truncating table: bronze.erp_px_cat_g1V2';
truncate table bronze.erp_px_cat_g1V2;
print 'Inserting table: bronze.erp_px_cat_g1V2';
bulk insert bronze.erp_px_cat_g1V2
from 'C:\Users\dines\OneDrive\Documents\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' 
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);
set @end_time = getdate();
print 'load duration:' +cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds ';
print '--------------------';

print '--------------------';
print 'loading bronze layer is completed'
print 'Total load duration:'+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + 'seconds ';;
print '--------------------';

end try
begin catch
print '=============================='
print 'error occured during loading bronze layer'
print 'error message'+error_message();
print 'error message'+ cast (error_number() as nvarchar);
print 'error message'+ cast (error_state() as nvarchar);
print '=============================='
end catch
end
