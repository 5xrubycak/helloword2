
# HelloWord

Having troubles memorizing new vocabulary ? Hello Word’s mission is to help people practice whatever and whenever they are learning. Users are provided with 3 options to login to our website: Facebook, Google or register as members our Hello Word. Hello Word introduces three most important features: Google Extension, Test, and Clone, which assist users master learning new languages. 


## Table of content

[Requirements](#Requirements)
[Usage](#Usage)  

  - [Install Dependency](#Install-Dependency)  
  - [Prepare Database](#Prepare-Database)
  - [Start server](#Start-server)
  - [Create public menus](#Create-public-menus)
  - [Modify application.yml file](#Modify-application.yml-file)
  - [Check routes](#Check-routes)
  - [Process](#Process)
  - [Chrome Extension API](#Chrome-Extension-API)

***

## Requirements

- Ruby version 2.6.0
- Rails version 5.2.3
- PostgreSQL 11.3
- Mailgun account

## Usage

### Install Dependency

```s
$ bundle install
```

### Prepare Database

If you didn't have database.

```
$ rails db:create
$ rails db:migrate
```

### Start server

Start Rails server.

```
$ rails s
```

### Modify application.yml file

To make "Action Mailer", "Active Storage work", "Facebook & Google API" work properly, you should customize your own `application.yml` file，for more info, please check `application.yml.sample` file and fill in your own credentials.

### Check routes:

Check rails routes for more detail:

```
$ rails routes
```


| Pages                | Prefix                 | URI Pattern                      |
| -------------------- | :--------------------- | :------------------------------- |
| User sign up:        | new_user_registration  | `/users/sign_up(.:format)`       |
| User sign in:        | new_user_session       | `/users/sign_in(.:format)`       |
| User edit:           | edit_user_registration | `/users/edit(.:format)`          |
| Homepage:            | setboxes               | `/helloword(.:format)`           |
| Setboxes you owned:  | home_setboxes          | `/helloword/home(.:format)`      |
| Create a new Setbox: | new_setbox             | `/helloword/new(.:format)`       |
| Search Setboxes:     | search_setboxes        | `/helloword/search(.:format)`    |
| Show a Setbox:       | setbox                 | `/helloword/:id(.:format)`       |
| Edit a Setbox:       | edit_setbox            | `/helloword/:id/edit(.:format)`  |
| Quiz a Setbox:       | write_setbox           | `/helloword/:id/write(.:format)` |

***

### Process

***

After login with email or with Google/Facebook account, visit `/helloword/new`, you are able to build a new study set with set title, term and definition for new word. 

- Create your first Setbox

Every study set you own are showen here. By simply click the title of your study set, you would see the content page which incldue the terms you created 

- View your created Setbox 

If you've already created a study set before, and need to copy the same study set again. You are able to do so, simply by clicking "Clone" button in the content page, then the copy version of that study set will show up in the `/helloword/home` 

- Copy your created Setbox

Click the study set title which you want to edit. Editing can be easily done by clicking "Edit" button on the right side of top content page, you will see the terms you created and start you editing process.

- Edit your created Setbox 

Click the study set title which you want to quiz. If you are interested in improving the language your are learning, you can hit the quiz button in the content page, and start your testing process.

- Quiz on current Setbox

To see all of your study sets, visit `/helloword/home` the Set List page, every study set you own are showen here.

- See all of your Setboxes

Stealing other people's study set can be done by typing keyword in the search area, all of the relative sets are shown below.）

- Search others users Setboxes

### Chrome Extension

***

If you are already a member of Hello Word, and you've already created a study set, you can download the chrome extension files and installed in your chrome browser.

Until you logout, you can still use the services we provide even you are visiting different websites. 

> [Hello Word Extension](https://drive.google.com/file/d/1QN-hSYOBu5BsxPQRBIooLxDLLbUf_w6m/view?usp=sharing)

Once the Hello Word extension is installed, and the login process is completed, you can create terms you want to save without actually visiting Hello Word website.

- Login your account (same as you create on website)

You need to have at least one study set created, then you can add the terms you are interested into the study set you selected.

- Add a Card_word and Card_def in your selected Setbox

If you want to logout to your browser, simply click X button to logout.

- Logout



# Chrome Extension API

***

## API URL

```
https://helloword.space/api/v1/{router}
```

## API List
- [Login](#HelloWord-Login)
- [AddSetbox](#Add-Setbox)
- [Logout](#HelloWord-Logout)

***

## HelloWord Login

#### Method & URL
```
Post /login
```

#### Parameter

##### Path parameter

`email`、`password`

#### Success Response
``` json
{
  "message": "ok",
  "auth_token": "iLEhUQYpwAtM2MbQVJxdnJNi",
  "setboxes": [
    {
      "id": 1,
      "title": "5xruby toeic",
      "created_at": "Fri, 18 Oct 2019 17:00:27 CST +08:00",
      "user_id": 1,
      "description": "旅遊"
    },
    {
      "id": 2,
      "title": "辦公室英語(1)",
      "created_at": "Fri, 18 Oct 2019 22:12:27 CST +08:00",
      "user_id": 1,
      "description": "多益辦公室"
    }
  ]
}
```

## Add Setbox

#### Method & URL
```
POST /addsetbox
```

#### Parameter

##### Path parameter

`id`、 `title`、`card_word`、`card_def`

```json
setbox: {
  "id": 1,
  "title": "5xruby toeic",
  "cards_attributes": [
    {
      "card_word": "5xruby",
      "card_def": "五倍紅寶石"
    },
  ]
}
```

##### Success Response

``` json
{ 
  "message": "addsetbox success"
}
```
## HelloWord Logout

#### Method & URL
```
Post /logout
```

#### Parameter
##### Path parameter

`auth_token`

#### Success Response
``` json
{
  "message": "you have been logged out",
  "auth_token": "TMgj8VEQgLvVMC4bHKVstxTP"
}
```
