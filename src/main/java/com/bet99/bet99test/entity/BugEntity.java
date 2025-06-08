package com.bet99.bet99test.entity;


import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Entity
@Table(name = "bugs")
@Data
public class BugEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Bug title is required.")
    @Size(min = 10, max = 50, message = "Bug title must be at least 10 characters long.")
    @Column(length = 50)
    private String bugTitle;
    @NotBlank(message = "Description is required.")
    @Size(min = 20, max = 255, message = "Description must be at least 20 characters long.")
    @Column(length = 255)
    private String description;
    @Enumerated(EnumType.STRING)
    private Severity severity;
    @Enumerated(EnumType.STRING)
    private Status status;
}