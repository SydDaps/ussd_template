# Ussd APP template
- One Main entry point is a post '/' in app.rb
- Every Dial is managed by the 
```ruby
Dial::Manager
```
- A first dial is haddled in the Main Menu
```ruby
Menu::Main
```
- Sudbsiquent dials are handled in the Menu Manger
```ruby
Menu::Manager
```
- All menus call required pages by page number most pages follow the convention
```ruby
Page::MENU_NAME::PAGE_NUMBER
```

  
