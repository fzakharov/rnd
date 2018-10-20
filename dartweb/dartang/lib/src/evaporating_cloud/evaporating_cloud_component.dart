import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'evaporating_cloud_service.dart';

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
  providers: [const ClassProvider(EvaporatingCloudService)],
)
class EvaporatingCloudComponent implements OnInit {
  final EvaporatingCloudService evaporatingCloudService;

  List<String> items = [];
  String newTodo = '';

  EvaporatingCloudComponent(this.evaporatingCloudService);

  @override
  Future<Null> ngOnInit() async {
    items = await evaporatingCloudService.getTodoList();
  }

  void add() {
    items.add(newTodo);
    newTodo = '';
  }

  String remove(int index) => items.removeAt(index);
}
