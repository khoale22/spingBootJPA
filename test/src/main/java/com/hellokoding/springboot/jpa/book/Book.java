package com.hellokoding.springboot.jpa.book;

import lombok.Data;

import javax.persistence.*;

@Data

@Entity
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    @ManyToOne
    @JoinColumn
    private BookCategory bookCategory;
    public Book(){}
    public Book(String name) {
        this.name = name;
    }
}
