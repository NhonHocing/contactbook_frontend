# Quy trình làm việc với Git

## Cấu trúc dự án

Dự án này có cấu trúc với các submodule:
- `fontend/contactbook_frontend` - Frontend chính (Vue.js)
- `backend_1` - Backend (Node.js)
- `PTUDWEB/PTUD_WED` - Dự án khác

## Quy trình commit và push code

### 1. Làm việc với Frontend (contactbook_frontend)

```bash
# Bước 1: Vào thư mục frontend
cd fontend/contactbook_frontend

# Bước 2: Kiểm tra trạng thái
git status

# Bước 3: Add các file đã thay đổi
git add .

# Hoặc add từng file cụ thể
git add src/views/ContactBook.vue
git add src/router/index.js

# Bước 4: Commit với message rõ ràng
git commit -m "Mô tả thay đổi: thêm tính năng X, sửa lỗi Y"

# Bước 5: Pull để đồng bộ với remote (nếu có thay đổi từ người khác)
git pull origin master

# Bước 6: Push lên GitHub
git push origin master
```

### 2. Cập nhật submodule trong repository chính

Sau khi commit và push trong submodule, cần cập nhật reference trong repo chính:

```bash
# Bước 1: Quay về thư mục gốc
cd E:\Hoc_phan\PTUD-Web\lab

# Bước 2: Add submodule đã thay đổi
git add fontend

# Bước 3: Commit reference mới
git commit -m "Update fontend submodule"

# Bước 4: Pull để đồng bộ
git pull origin master

# Bước 5: Push
git push origin master
```

## Quy trình đầy đủ (Recommended)

### Khi có thay đổi trong frontend:

```bash
# 1. Vào thư mục frontend
cd fontend/contactbook_frontend

# 2. Kiểm tra thay đổi
git status

# 3. Add và commit
git add .
git commit -m "Mô tả thay đổi"

# 4. Pull trước khi push (quan trọng!)
git pull origin master

# 5. Push lên GitHub
git push origin master

# 6. Quay về thư mục gốc và cập nhật submodule
cd ../..
git add fontend
git commit -m "Update fontend submodule"
git pull origin master
git push origin master
```

## Xử lý lỗi thường gặp

### Lỗi: "Updates were rejected because the tip of your current branch is behind"

**Nguyên nhân:** Remote có commit mới hơn local

**Giải pháp:**
```bash
git pull origin master
# Giải quyết conflict nếu có
git push origin master
```

### Lỗi: "No configured push destination"

**Nguyên nhân:** Chưa có remote repository

**Giải pháp:**
```bash
git remote add origin https://github.com/NhonHocing/contactbook_frontend.git
git push -u origin master
```

### Lỗi: "modified content" trong submodule

**Nguyên nhân:** Submodule có thay đổi chưa được commit

**Giải pháp:**
```bash
# Vào thư mục submodule
cd fontend/contactbook_frontend

# Commit các thay đổi
git add .
git commit -m "Mô tả thay đổi"
git push origin master

# Quay về repo chính và cập nhật
cd ../..
git add fontend
git commit -m "Update fontend submodule"
git push origin master
```

## Best Practices

1. **Luôn pull trước khi push** để tránh conflict
2. **Commit message rõ ràng** mô tả chính xác thay đổi
3. **Commit thường xuyên** thay vì commit một lần nhiều thay đổi
4. **Kiểm tra git status** trước khi commit
5. **Không commit node_modules** (đã có trong .gitignore)

## Lệnh hữu ích

```bash
# Xem lịch sử commit
git log --oneline

# Xem thay đổi chưa commit
git diff

# Xem remote repositories
git remote -v

# Xem branch hiện tại
git branch

# Xem trạng thái
git status
```









