import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'evaporating-cloud',
  styleUrls: ['evaporating_cloud_component.css'],
  templateUrl: 'evaporating_cloud_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
)
class EvaporatingCloudComponent implements OnInit {
  List<String> items = [];
  String newTodo = '';

  EvaporatingCloudComponent();

  @override
  Future<Null> ngOnInit() async {

  }

  void add() {
    items.add(newTodo);
    newTodo = '';
  }

  String remove(int index) => items.removeAt(index);
}
