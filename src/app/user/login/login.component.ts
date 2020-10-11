import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  isRegister:Boolean = false;
  constructor(
    private route: ActivatedRoute,
  ) { }

  ngOnInit(): void {
    //document.body.style.backgroundColor = "#e43c5c";
  }

  toggleRegister(){
    this.isRegister = !this.isRegister;
  }

}
