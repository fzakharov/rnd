import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:dartang/src/evaporating_cloud/LogicalEntity.dart';
import 'package:dartang/src/evaporating_cloud/logical_entity_component.dart';

@Component(
  selector: 'evaporating-cloud',
  styleUrls: ['evaporating_cloud_component.css'],
  templateUrl: 'evaporating_cloud_component.html',
  directives: [
    materialInputDirectives,
    NgFor,
    NgIf,
    LogicalEntityComponent,
  ],
)
class EvaporatingCloudComponent implements OnInit {
    EvaporatingCloudComponent();

    LogicalEntity objective;

    String Title = 'no';

  @override
  Future<Null> ngOnInit() async {
    objective = new LogicalEntity();
    objective.Label = 'Цель:';
    objective.Expression = 'что бы как бы';
  }

  update() async {
    //Title = 'Для того чтобы ' + Objective + ' мы должны...';
  }
}
