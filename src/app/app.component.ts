import { trigger, state, transition, animate, style } from '@angular/animations';
import { Component, ComponentFactoryResolver } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  animations: [
    trigger('toggleMenu', [
      transition('false => false', [
        animate('0.5s')
      ]),
    ]),
  ]
})
export class AppComponent {

  showMenu:Boolean = true;
  title = 'elastikchain';

  toggleMenu(){
    this.showMenu = !this.showMenu;
  }

}
