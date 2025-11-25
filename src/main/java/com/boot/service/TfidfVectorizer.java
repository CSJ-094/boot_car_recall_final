package com.boot.service;

import java.util.*;

public class TfidfVectorizer {
    private List<String> vocabulary = new ArrayList<>();
    private Map<String, Integer> df = new HashMap<>();
    private int totalDocs;

    public List<double[]> fitTransform(List<String> docs) {
        totalDocs = docs.size();

        // 문서 토큰화
        List<List<String>> tokenized = docs.stream()
                .map(d -> Arrays.asList(d.toLowerCase().split("\\s+")))
                .toList();

        // vocabulary + DF 계산
        for (List<String> tokens : tokenized) {
            Set<String> seen = new HashSet<>();
            for (String t : tokens) {
                if (!vocabulary.contains(t)) {
                    vocabulary.add(t);
                }
                if (!seen.contains(t)) {
                    df.put(t, df.getOrDefault(t, 0) + 1);
                    seen.add(t);
                }
            }
        }

        // TF-IDF 변환
        List<double[]> vectors = new ArrayList<>();
        for (List<String> tokens : tokenized) {
            vectors.add(transform(tokens));
        }
        return vectors;
    }

    public double[] transformOne(String doc) {
        List<String> tokens = Arrays.asList(doc.toLowerCase().split("\\s+"));
        return transform(tokens);
    }

    private double[] transform(List<String> tokens) {
        double[] vector = new double[vocabulary.size()];

        Map<String, Integer> tf = new HashMap<>();
        for (String t : tokens) {
            tf.put(t, tf.getOrDefault(t, 0) + 1);
        }

        for (int i = 0; i < vocabulary.size(); i++) {
            String term = vocabulary.get(i);
            int tfCount = tf.getOrDefault(term, 0);
            int dfCount = df.getOrDefault(term, 1);

            double idf = Math.log((double) totalDocs / dfCount);
            vector[i] = tfCount * idf;
        }

        return vector;
    }
}
