/*
 * Copyright (c) 2015 the authors of j2objc-common-libs-e2e-test
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.github.j2objccontrib.j2objcgradle;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CoreJacksonDataBindMarshallingTest {

    private static String jsonValue = "{\n" +
            "  \"addressList\": [\n" +
            "    {\n" +
            "      \"zipcode\": 12345,\n" +
            "      \"street\": \"Stenhammer Drive\"\n" +
            "    },\n" +
            "    {\n" +
            "      \"zipcode\": 7986,\n" +
            "      \"street\": \"Market Street\"\n" +
            "    }\n" +
            "  ],\n" +
            "  \"singleAddress\": {\n" +
            "    \"zipcode\": 7986,\n" +
            "    \"street\": \"Market Street\"\n" +
            "  }\n" +
            "}" ;

    @Test
    public void testMarshalling() throws IOException {
        Address homeAddress = new Address(12345, "Stenhammer Drive");
        Address workAddress = new Address(7986, "Market Street");
        ArrayList<Address> addressList = new ArrayList<>();
        addressList.add(homeAddress);
        addressList.add(workAddress);
        Person person = new Person(addressList);
        person.setSingleAddress(workAddress);

        ObjectMapper objectMapper = new ObjectMapper();
        String value = objectMapper.writeValueAsString(person);

        JsonNode expected = objectMapper.readTree(jsonValue);
        JsonNode actual = objectMapper.readTree(value);
        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDemarshallingWithEmbeddedObject() throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Person personValue = objectMapper.readValue(jsonValue, Person.class);
        Assert.assertTrue(personValue.getSingleAddress() instanceof Address);
        Assert.assertEquals(7986, personValue.singleAddress.zipcode);
        Assert.assertEquals("Market Street", personValue.singleAddress.street);
    }

    // This test is expected to fail until j2objc is updated to a version where
    // this issue is fixed: https://github.com/google/j2objc/issues/639
    @Test
    public void testDemarshallingListField() throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Person personValue = objectMapper.readValue(jsonValue, Person.class);

        List<Address> addresses = personValue.getAddressList();
        Assert.assertEquals(2, addresses.size());
        Address firstAddress = addresses.get(0);
        Assert.assertTrue(firstAddress instanceof Address);

        Assert.assertEquals(12345, firstAddress.zipcode);
        Assert.assertEquals("Stenhammer Drive", firstAddress.street);
    }

    public static class Person {

        private ArrayList<Address> addressList;
        private Address singleAddress;

        public Person(ArrayList<Address> addressList) {
            this.addressList = addressList;
        }

        Person() {
        }

        public List<Address> getAddressList() {
            return addressList;
        }

        public void setAddressList(ArrayList<Address> addressList) {
            this.addressList = addressList;
        }

        public Address getSingleAddress() {
            return singleAddress;
        }

        public void setSingleAddress(Address singleAddress) {
            this.singleAddress = singleAddress;
        }
    }

    public static class Address {

        private int zipcode;
        private String street;

        Address() {
        }

        public Address(int zipcode,
                       String street) {
            this.zipcode = zipcode;
            this.street = street;
        }

        public int getZipcode() {
            return zipcode;
        }

        public String getStreet() {
            return street;
        }

        public void setZipcode(int zipcode) {
            this.zipcode = zipcode;
        }

        public void setStreet(String street) {
            this.street = street;
        }
    }
} 
