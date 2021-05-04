class User {  
    User(name, phoneNumer, email, roles = ['Customer'], birthDate, bookings = []) {
        this.name = name;
        this.phoneNumer = phoneNumer;
        this.email = email;
        this.roles = roles; 
        this.birthDate = birthDate;
        this.bookings = bookings;
    }
}