package com.mini.projet.gl5.spring_boot.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping(path = "/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Object> index() {
        String[] resp = new String[2];
        resp[0] = "Hello";
        resp[1] = "World";
        return new ResponseEntity<Object>(resp, HttpStatus.OK);
    }

    @GetMapping(path = "/hello", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Object> index2() {
        String[] resp = new String[2];
        resp[0] = "Hello";
        resp[1] = "World";
        return new ResponseEntity<Object>(resp, HttpStatus.OK);
    }

}