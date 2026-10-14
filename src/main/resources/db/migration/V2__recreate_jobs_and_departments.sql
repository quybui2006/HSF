-- 1. Xóa các ràng buộc khóa ngoại cũ trỏ vào bảng jobs và departments
ALTER TABLE employees DROP CONSTRAINT IF EXISTS fk_employees_jobs;
ALTER TABLE employees DROP CONSTRAINT IF EXISTS fk_employees_departments;
ALTER TABLE job_history DROP CONSTRAINT IF EXISTS fk_job_history_jobs;
ALTER TABLE job_history DROP CONSTRAINT IF EXISTS fk_job_history_departments;
ALTER TABLE departments DROP CONSTRAINT IF EXISTS fk_departments_locations;
ALTER TABLE departments DROP CONSTRAINT IF EXISTS fk_departments_manager;
GO

-- 2. Xóa bảng jobs và departments cũ
DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS skills;
GO

-- 3. Tạo lại bảng DEPARTMENTS khớp với Department.java & BaseEntity
CREATE TABLE departments (
                             id BIGINT IDENTITY(1,1) PRIMARY KEY,
                             department_name NVARCHAR(50) NOT NULL,
                             description NVARCHAR(MAX) NULL,
                             created_at DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
                             updated_at DATETIMEOFFSET NULL,
                             created_by VARCHAR(255) NULL,
                             updated_by VARCHAR(255) NULL,
                             is_deleted BIT NOT NULL DEFAULT 0,
                             deleted_at DATETIMEOFFSET NULL
);
GO

-- 4. Tạo lại bảng JOBS khớp với Job.java & BaseEntity
CREATE TABLE jobs (
                      id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
                      title NVARCHAR(500) NULL,
                      description NVARCHAR(MAX) NULL,
                      location NVARCHAR(500) NULL,
                      salary_min DECIMAL(15, 2) NULL,
                      salary_max DECIMAL(15, 2) NULL,
                      status VARCHAR(50) NULL,
                      utm_source VARCHAR(150) NULL,
                      utm_medium VARCHAR(150) NULL,
                      deadline DATETIMEOFFSET NULL,
                      published_at DATETIMEOFFSET NULL,
                      department_id BIGINT NULL,
                      created_at DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
                      updated_at DATETIMEOFFSET NULL,
                      created_by VARCHAR(255) NULL,
                      updated_by VARCHAR(255) NULL,
                      is_deleted BIT NOT NULL DEFAULT 0,
                      deleted_at DATETIMEOFFSET NULL,
                      CONSTRAINT fk_jobs_departments FOREIGN KEY (department_id) REFERENCES departments(id)
);
GO

-- 5. Tạo bảng SKILLS và bảng nối JOB_SKILLS khớp với Skill.java
CREATE TABLE skills (
                        id BIGINT IDENTITY(1,1) PRIMARY KEY,
                        skill_name NVARCHAR(255) NULL,
                        category NVARCHAR(255) NULL,
                        status VARCHAR(50) NULL,
                        created_at DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
                        updated_at DATETIMEOFFSET NULL,
                        created_by VARCHAR(255) NULL,
                        updated_by VARCHAR(255) NULL,
                        is_deleted BIT NOT NULL DEFAULT 0,
                        deleted_at DATETIMEOFFSET NULL
);
GO

CREATE TABLE job_skills (
                            job_id UNIQUEIDENTIFIER NOT NULL,
                            skill_id BIGINT NOT NULL,
                            PRIMARY KEY (job_id, skill_id),
                            CONSTRAINT fk_job_skills_jobs FOREIGN KEY (job_id) REFERENCES jobs(id),
                            CONSTRAINT fk_job_skills_skills FOREIGN KEY (skill_id) REFERENCES skills(id)
);
GO

-- 6. Dữ liệu mẫu ban đầu để giao diện /jobs có dữ liệu hiển thị
INSERT INTO departments (department_name, description)
VALUES ('Software Development', 'Phong phat trien phan mem');
GO

INSERT INTO jobs (title, description, location, salary_min, salary_max, status, department_id)
VALUES
    ('Senior Java Backend Developer', 'Develop Spring Boot microservices', 'Ha Noi', 25000000, 45000000, 'OPEN', 1),
    ('Frontend React Developer', 'Build UI dashboards', 'Ho Chi Minh', 18000000, 30000000, 'OPEN', 1);
GO