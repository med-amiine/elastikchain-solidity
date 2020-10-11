import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { HomeComponent } from './home/home.component';
import { CategoriesComponent } from './user/categories/categories.component';
import { UserComponent } from './user/user.component';
import { LoginComponent } from './user/login/login.component';
import { ProjectsComponent } from './user/projects/projects.component';
import { ProjectDescriptionComponent } from './user/projects/project-description/project-description.component';



@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    CategoriesComponent,
    UserComponent,
    LoginComponent,
    ProjectsComponent,
    ProjectDescriptionComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    NgbModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
