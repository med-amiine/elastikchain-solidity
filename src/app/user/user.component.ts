import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
  
  showMenu:Boolean = true;
  constructor() { }

  ngOnInit(): void {
  }


  toggleMenu(){
    this.showMenu = !this.showMenu;
  }

}
