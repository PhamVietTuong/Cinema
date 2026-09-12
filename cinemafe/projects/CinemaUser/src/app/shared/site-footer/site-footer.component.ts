import { Component } from '@angular/core';
import { SharedModule } from 'CinemaLib';

/** Shared site footer — previously duplicated (with drifted content) across Home and the Movies list. */
@Component({
  selector: 'app-site-footer',
  standalone: true,
  imports: [SharedModule],
  templateUrl: './site-footer.component.html',
  styleUrl: './site-footer.component.scss',
})
export class SiteFooterComponent {}
