-- 1. Bảng REGIONS
CREATE TABLE regions (
                         region_id INT IDENTITY(1,1) PRIMARY KEY,
                         region_name NVARCHAR(50) NOT NULL
);

-- 2. Bảng COUNTRIES
CREATE TABLE countries (
                           country_id VARCHAR(5) PRIMARY KEY,
                           country_name NVARCHAR(100) NOT NULL,
                           region_id INT NOT NULL,
                           CONSTRAINT fk_countries_regions FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- 3. Bảng LOCATIONS
CREATE TABLE locations (
                           location_id INT IDENTITY(1,1) PRIMARY KEY,
                           street_address NVARCHAR(255),
                           postal_code NVARCHAR(20),
                           city NVARCHAR(100) NOT NULL,
                           state_province NVARCHAR(100),
                           country_id VARCHAR(5) NOT NULL,
                           CONSTRAINT fk_locations_countries FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- 4. Bảng JOBS
CREATE TABLE jobs (
                      job_id VARCHAR(20) PRIMARY KEY,
                      job_title NVARCHAR(100) NOT NULL,
                      min_salary DECIMAL(15, 2),
                      max_salary DECIMAL(15, 2)
);

-- 5. Bảng DEPARTMENTS
CREATE TABLE departments (
                             department_id INT IDENTITY(1,1) PRIMARY KEY,
                             department_name NVARCHAR(100) NOT NULL,
                             manager_id INT NULL,
                             location_id INT NULL,
                             CONSTRAINT fk_departments_locations FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- 6. Bảng EMPLOYEES
CREATE TABLE employees (
                           employee_id INT IDENTITY(1,1) PRIMARY KEY,
                           first_name NVARCHAR(50),
                           last_name NVARCHAR(50) NOT NULL,
                           email NVARCHAR(100) NOT NULL UNIQUE,
                           phone_number NVARCHAR(30),
                           hire_date DATE NOT NULL,
                           job_id VARCHAR(20) NOT NULL,
                           salary DECIMAL(15, 2) NOT NULL,
                           commission_pct DECIMAL(5, 2),
                           manager_id INT NULL,
                           department_id INT NULL,
                           CONSTRAINT fk_employees_jobs FOREIGN KEY (job_id) REFERENCES jobs(job_id),
                           CONSTRAINT fk_employees_departments FOREIGN KEY (department_id) REFERENCES departments(department_id),
                           CONSTRAINT fk_employees_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Tạo ràng buộc manager_id cho DEPARTMENTS sau khi EMPLOYEES đã tồn tại
ALTER TABLE departments
    ADD CONSTRAINT fk_departments_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

-- 7. Bảng JOB_HISTORY
CREATE TABLE job_history (
                             employee_id INT NOT NULL,
                             start_date DATE NOT NULL,
                             end_date DATE NOT NULL,
                             job_id VARCHAR(20) NOT NULL,
                             department_id INT NOT NULL,
                             PRIMARY KEY (employee_id, start_date),
                             CONSTRAINT fk_job_history_employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
                             CONSTRAINT fk_job_history_jobs FOREIGN KEY (job_id) REFERENCES jobs(job_id),
                             CONSTRAINT fk_job_history_departments FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 8. Bảng UNIVERSITIES (Dành cho giao diện Candidate hiện tại)
CREATE TABLE universities (
                              id UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
                              unis_name VARCHAR(255) NOT NULL UNIQUE,
                              address VARCHAR(255) NULL,
                              unis_phone VARCHAR(255) NULL
);

-- 9. Bảng CANDIDATES (Dành cho giao diện Candidate hiện tại)
CREATE TABLE candidates (
                            id BIGINT IDENTITY(1,1) PRIMARY KEY,
                            full_name VARCHAR(255) NULL,
                            email VARCHAR(255) NULL,
                            password VARCHAR(255) NULL,
                            phone_number VARCHAR(255) NULL,
                            status VARCHAR(50) NULL,
                            unis_id UNIQUEIDENTIFIER NULL,
                            CONSTRAINT fk_candidates_universities FOREIGN KEY (unis_id) REFERENCES universities(id)
);