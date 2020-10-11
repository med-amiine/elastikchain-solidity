import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { CategoriesComponent } from './user/categories/categories.component';
import { LoginComponent } from './user/login/login.component';
import { ProjectsComponent } from './user/projects/projects.component';
import { UserComponent } from './user/user.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { 
    path: 'user', 
    component: UserComponent,
    children: [
      {
        path: 'categories', component: CategoriesComponent
      },
      {
        path: 'projects', component: ProjectsComponent
      }
    ] 
  },
  { path: 'login', component: LoginComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
