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
class EvaporatingCloudComponent implements OnInit, OnChanges {
    EvaporatingCloudComponent();

    LogicalEntity objective;
    LogicalEntity bRequirement;
    LogicalEntity dPrerequisite;
    LogicalEntity cRequirement;
    LogicalEntity dAltPrerequisite;

    String Title = 'no';

  @override
  Future<Null> ngOnInit() async {
    objective = new LogicalEntity();
    bRequirement = new LogicalEntity();
    dPrerequisite = new LogicalEntity();
    cRequirement = new LogicalEntity();
    dAltPrerequisite = new LogicalEntity();

    objective.label = 'Цель:';
    objective.expression = 'что бы как бы';
  }

  update() async {
    Title = 'Для того чтобы ' + objective.expression + ' мы должны...';
  }

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    Title = 'Для того чтобы ' + objective.expression + ' мы должны...';
  }
}
