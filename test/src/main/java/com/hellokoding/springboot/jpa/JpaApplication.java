package com.hellokoding.springboot.jpa;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.hellokoding.springboot.jpa.book.Book;
import com.hellokoding.springboot.jpa.book.BookCategory;
import com.hellokoding.springboot.jpa.book.BookCategoryRepository;
import com.hellokoding.springboot.jpa.book.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import static sun.plugin2.util.PojoUtil.toJson;

@SpringBootApplication
public class JpaApplication implements CommandLineRunner {
    @Autowired
    private BookCategoryRepository bookCategoryRepository;

    @Autowired
    private BookRepository bookRepository;

    public static void main(String[] args) {
        SpringApplication.run(JpaApplication.class, args);
    }

    @Override
    public void run(String... args) {
        // Create a couple of Book and BookCategory
     /*  bookCategoryRepository.save(new BookCategory("Category 1", new Book("Hello Koding 1"), new Book("Hello Koding 2")));*/
       /* BookCategory bookCategory = new BookCategory("abc2");
        bookCategoryRepository.save(bookCategory);*/

        Book book = bookRepository.findById(1).get();
       /* System.out.println(bookCategory);*/
        System.out.println("---------------------------------------------------------------------------------------------");
        System.out.println(toJson(book));
    }
}
