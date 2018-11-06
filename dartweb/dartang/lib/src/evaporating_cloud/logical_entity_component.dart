import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:dartang/src/evaporating_cloud/LogicalEntity.dart';

@Component(
  selector: 'logical-entity',
  styleUrls: ['logical_entity_component.css'],
  templateUrl: 'logical_entity_component.html',
  directives: [
    materialInputDirectives,
  ],
)
class LogicalEntityComponent {
  LogicalEntityComponent();

  @Input()
  LogicalEntity entity;
}
