package com.hellokoding.springboot.jpa;

import com.hellokoding.springboot.jpa.book.Book;
import com.hellokoding.springboot.jpa.book.BookCategory;
import com.hellokoding.springboot.jpa.book.BookCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class JpaApplication implements CommandLineRunner {
    @Autowired
    private BookCategoryRepository bookCategoryRepository;

    public static void main(String[] args) {
        SpringApplication.run(JpaApplication.class, args);
    }

    @Override
    public void run(String... args) {
        // Create a couple of Book and BookCategory
     /*  bookCategoryRepository.save(new BookCategory("Category 1", new Book("Hello Koding 1"), new Book("Hello Koding 2")));*/
       /* BookCategory bookCategory = new BookCategory("abc");
        bookCategoryRepository.save(bookCategory);*/
       int id = 4;
        BookCategory bookCategory = bookCategoryRepository.findById(4).get();
        System.out.println(bookCategory);

        bookCategoryRepository.delete(bookCategory);


    }
}
