import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class EntityService {

  constructor(private http: HttpClient) {
  }

  getEntities(): void {
  }
}
