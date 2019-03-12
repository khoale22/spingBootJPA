package com.hellokoding.springboot.jpa.book;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Data
@EqualsAndHashCode(exclude = "books")

@Entity
public class BookCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "bookCategory", cascade = CascadeType.ALL , fetch = FetchType.LAZY)
    private Set<Book> books;

    public BookCategory(){}
    public BookCategory(String name, Book... books) {
        this.setName(name);
        this.setBooks(Stream.of(books).collect(Collectors.toSet()));
      // this.books.forEach(x -> x.setBookCategory(this));
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Book> getBooks() {
        return books;
    }

    public void setBooks(Set<Book> books) {
        this.books = books;
    }
}
