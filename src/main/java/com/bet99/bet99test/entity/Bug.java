package com.bet99.bet99test.entity;


import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "bugs")
@Data
public class Bug {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String bugTitle;
    private String description;
    @Enumerated(EnumType.STRING)
    private Severity severity;
    @Enumerated(EnumType.STRING)
    private Status status;
}