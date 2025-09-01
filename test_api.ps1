# PowerShell script to test the API endpoints

$baseUrl = "https://sme.sosme.api.elitevigour.com"
$token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjo0OTA4MjIwNzAzLCJqdGkiOiIyNTljZjgxOTM1OWQ0YWIwOWNiODViMDViODQ2OWExYSIsInVzZXJfaWQiOjU2LCJsYW5nIjoiZW4ifQ.Y8zmpxCDqfjWiau6zzpCyRRFEQF3Vk38oEBZoq5XwXs"

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

Write-Host "Testing API Connection..." -ForegroundColor Yellow

try {
    # Test 1: Get Purchase Status List
    Write-Host "`n=== Testing Purchase Status List ===" -ForegroundColor Cyan
    $statusUrl = "$baseUrl/api/v3/public/ecom-purchase-status/get-list?language_code=EN"
    Write-Host "URL: $statusUrl" -ForegroundColor Gray
    
    $statusResponse = Invoke-WebRequest -Uri $statusUrl -Headers $headers -Method GET
    Write-Host "Status Code: $($statusResponse.StatusCode)" -ForegroundColor Green
    Write-Host "Response Body:" -ForegroundColor Green
    $statusResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
    
    # Test 2: Get Order Details
    Write-Host "`n=== Testing Order Details (ID: 120) ===" -ForegroundColor Cyan
    $orderUrl = "$baseUrl/api/v3/public/ecom-purchase-records/get-detail?language_code=EN&ecom_purchase_records_id=120"
    Write-Host "URL: $orderUrl" -ForegroundColor Gray
    
    $orderResponse = Invoke-WebRequest -Uri $orderUrl -Headers $headers -Method GET
    Write-Host "Status Code: $($orderResponse.StatusCode)" -ForegroundColor Green
    Write-Host "Response Body:" -ForegroundColor Green
    $orderResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
    
} catch {
    Write-Host "Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        Write-Host "HTTP Status: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
        Write-Host "Response: $($_.Exception.Response.Content)" -ForegroundColor Red
    }
}

Write-Host "`nAPI Test Completed!" -ForegroundColor Yellow
