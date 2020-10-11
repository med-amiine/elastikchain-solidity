import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PrejectDescriptionComponent } from './preject-description.component';

describe('PrejectDescriptionComponent', () => {
  let component: PrejectDescriptionComponent;
  let fixture: ComponentFixture<PrejectDescriptionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PrejectDescriptionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PrejectDescriptionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
