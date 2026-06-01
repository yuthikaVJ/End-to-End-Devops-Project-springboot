package com.devops.demo.controller;

import com.devops.demo.model.Employee;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/employees")
public class EmployeeController {
    @GetMapping
    public List<Employee> getAllEmployees() {
        return List.of(
                new Employee(1L, "John", "Developer"),
                new Employee(2L, "Alice", "QA Engineer"),
                new Employee(3L, "Bob", "DevOps Engineer")
        );
    }

    @GetMapping("/{id}")
    public Employee getEmployeeById(@PathVariable Long id) {
        return new Employee(id, "John", "Developer");
    }
}
