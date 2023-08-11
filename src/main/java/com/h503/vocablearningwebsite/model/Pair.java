package com.h503.vocablearningwebsite.model;

import java.util.Objects;

public class Pair{
    private String term;
    private String definition;

    public Pair(String term, String definition) {
        this.term = term;
        this.definition = definition;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getDefinition() {
        return definition;
    }

    public void setDefinition(String definition) {
        this.definition = definition;
    }
}
