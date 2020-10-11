import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { NgbModal, NgbRatingConfig } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-preject-description',
  templateUrl: './project-description.component.html',
  styleUrls: ['./project-description.component.css']
})
export class ProjectDescriptionComponent implements OnInit {

  closeResult = '';
  currentRate = 0;
  idPage;
  model = {
    yes: true,
    no: false
  };
  
  constructor(
    private modalService: NgbModal,
    config: NgbRatingConfig,
    private route: ActivatedRoute
    ) {
      // customize default values of ratings used by this component tree
    config.max = 5;
  }

  ngOnInit(): void {
    this.idPage = this.route.snapshot.paramMap.get('id');
  }
  open(vote) {
    this.modalService.open(vote, {ariaLabelledBy: 'modal-basic-title'});
  }

}
