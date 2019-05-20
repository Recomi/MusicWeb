package bean;

import java.io.Serializable;

public class User implements Serializable {
    public static final int MALE = 0;
    public static final int FEMALE = 1;
    public static final int OTHER = 2;

    private String userName = null;
    private String email = null;
    private String age = null;
    private int sex = OTHER;
    private String firstName = null;
    private String lastName = null;

    public User() { }

    public User(String userName, String email, String age, int sex, String firstName, String lastName) {
        this.userName = userName;
        this.email = email;
        this.age = age;
        this.sex = sex;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public static int getMALE() {
        return MALE;
    }

    public static int getFEMALE() {
        return FEMALE;
    }

    public static int getOTHER() {
        return OTHER;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
