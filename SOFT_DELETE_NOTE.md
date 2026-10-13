# Soft Delete

## Code đã sửa

Trong `JobServiceImpl.delete()`:

```java
Job job = jobRepository.findById(id).orElseThrow(() -> {
    throw new IllegalArgumentException("Job not found!");
});

// Soft delete: không xóa dữ liệu thật, chỉ đánh dấu bản ghi đã bị xóa.
job.setDeleted(true);
job.setDeletedAt(OffsetDateTime.now());
jobRepository.save(job);
```

## Giải thích

- `findById(id)`: tìm Job theo ID.
- `orElseThrow(...)`: nếu không tìm thấy Job thì báo lỗi `Job not found!`.
- `setDeleted(true)`: đánh dấu Job đã bị xóa.
- `setDeletedAt(OffsetDateTime.now())`: lưu thời điểm xóa hiện tại.
- `save(job)`: cập nhật hai giá trị trên vào database.

Không gọi `deleteById(id)`, vì hàm đó sẽ xóa vĩnh viễn dòng dữ liệu khỏi database.

Hai cột sử dụng là `is_deleted` và `deleted_at`, được khai báo sẵn trong `BaseEntity`.
