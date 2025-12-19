# Script tự động commit và push code cho contactbook_frontend
# Sử dụng: .\git-push.ps1 "Mô tả commit message"

param(
    [Parameter(Mandatory=$true)]
    [string]$CommitMessage
)

Write-Host "=== Quy trình Git cho ContactBook Frontend ===" -ForegroundColor Cyan

# Bước 1: Vào thư mục frontend
Write-Host "`n[1/6] Chuyển đến thư mục frontend..." -ForegroundColor Yellow
Set-Location "fontend\contactbook_frontend"

if (-not (Test-Path ".git")) {
    Write-Host "Lỗi: Không tìm thấy git repository!" -ForegroundColor Red
    exit 1
}

# Bước 2: Kiểm tra trạng thái
Write-Host "[2/6] Kiểm tra trạng thái git..." -ForegroundColor Yellow
$status = git status --short
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "Không có thay đổi nào để commit." -ForegroundColor Green
    Set-Location "..\.."
    exit 0
}

Write-Host "Các thay đổi:" -ForegroundColor Cyan
git status --short

# Bước 3: Add các file
Write-Host "`n[3/6] Thêm các file vào staging..." -ForegroundColor Yellow
git add .

# Bước 4: Commit
Write-Host "[4/6] Commit với message: $CommitMessage" -ForegroundColor Yellow
git commit -m $CommitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "Lỗi khi commit!" -ForegroundColor Red
    Set-Location "..\.."
    exit 1
}

# Bước 5: Pull trước khi push
Write-Host "`n[5/6] Pull từ remote để đồng bộ..." -ForegroundColor Yellow
git pull origin master

if ($LASTEXITCODE -ne 0) {
    Write-Host "Có conflict hoặc lỗi khi pull. Vui lòng xử lý thủ công." -ForegroundColor Red
    Set-Location "..\.."
    exit 1
}

# Bước 6: Push
Write-Host "[6/6] Push lên GitHub..." -ForegroundColor Yellow
git push origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ Đã push thành công lên GitHub!" -ForegroundColor Green
    
    # Cập nhật submodule trong repo chính
    Write-Host "`n=== Cập nhật submodule trong repository chính ===" -ForegroundColor Cyan
    Set-Location "..\.."
    
    Write-Host "Thêm submodule vào staging..." -ForegroundColor Yellow
    git add fontend
    
    Write-Host "Commit submodule update..." -ForegroundColor Yellow
    git commit -m "Update fontend submodule"
    
    Write-Host "Pull từ remote..." -ForegroundColor Yellow
    git pull origin master
    
    Write-Host "Push lên GitHub..." -ForegroundColor Yellow
    git push origin master
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✓ Hoàn tất! Tất cả thay đổi đã được push lên GitHub." -ForegroundColor Green
    } else {
        Write-Host "`n⚠ Có lỗi khi push submodule. Vui lòng kiểm tra thủ công." -ForegroundColor Yellow
    }
} else {
    Write-Host "`n✗ Lỗi khi push!" -ForegroundColor Red
    Set-Location "..\.."
    exit 1
}









