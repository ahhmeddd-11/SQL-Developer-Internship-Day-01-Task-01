create database if not exists library_db;
use library_db;

create table authors (
  author_id int auto_increment primary key,
  name varchar(100) not null,
  birth_year year null,
  country varchar(50) default 'unknown'
);

create table books (
  book_id int auto_increment primary key,
  title varchar(255) not null,
  isbn varchar(20) unique,
  published_year year,
  copies int not null default 1,
  author_id int null,
  index (author_id),
  constraint fk_books_author foreign key (author_id)
    references authors(author_id) on delete set null on update cascade
);

create table members (
  member_id int auto_increment primary key,
  name varchar(100) not null,
  email varchar(150) unique,
  joined_date date
);

create table loans (
  loan_id int auto_increment primary key,
  book_id int not null,
  member_id int not null,
  loan_date date not null ,
  return_date date default null,
  constraint fk_loans_book foreign key (book_id)
    references books(book_id) on delete cascade on update cascade,
  constraint fk_loans_member foreign key (member_id)
    references members(member_id) on delete cascade on update cascade
);

create table book_authors (
  book_id int not null,
  author_id int not null,
  primary key (book_id, author_id),
  constraint fk_ba_book foreign key (book_id) references books(book_id) on delete cascade,
  constraint fk_ba_author foreign key (author_id) references authors(author_id) on delete cascade
);