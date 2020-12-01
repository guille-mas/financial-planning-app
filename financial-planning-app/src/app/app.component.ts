import { Component } from '@angular/core';
import { AdvancedPieChartComponent } from '@swimlane/ngx-charts';
import {single, multi} from './data';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'financial planning';
  single: any[];
  multi: any[];
  view: any[] = [700, 400];

  colorScheme = {
    domain: ['#5AA454', '#A10A28', '#C7B42C', '#AAAAAA']
  };

  constructor() {
    this.single = single;
    this.multi = multi;
  }

  onSelect(event: any) {
    console.log(event);
  }


}


interface IDataRow {
  name: string;
  value: number;
  extra: {
    code: 'it'|'es'|'uk'|'us'|'fr'|'de'
  };
}
