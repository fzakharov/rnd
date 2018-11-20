import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:dartang/src/evaporating_cloud/logical_entity_component.dart';
import 'package:dartang/src/evaporating_cloud/validation_expression_component.dart';
import 'package:dartang/src/model/Entity.dart';

@Component(
  selector: 'evaporating-cloud',
  styleUrls: ['evaporating_cloud_component.css'],
  templateUrl: 'evaporating_cloud_component.html',
  directives: [
    materialInputDirectives,
    NgFor,
    NgIf,
    LogicalEntityComponent,
    ValidationExpressionComponent,
  ],
  pipes: [commonPipes],
)
class EvaporatingCloudComponent implements OnInit, OnChanges {
  
  @Output()
  EvaporatingCloud cloud;
  String prefixExpression = "Для того чтобы";
  ABValidationExpression abExp;
  ACValidationExpression acExp;
  BDValidationExpression bdExp;
  CDAltValidationExpression cdAltExp;
  DDAltValidationExpression ddAltExp;

  DCValidationExpression dcExp;
  DAltBValidationExpression dAltbExp;

  EvaporatingCloudComponent() {
    cloud = new EvaporatingCloud();
    abExp = new ABValidationExpression(cloud);
    acExp = new ACValidationExpression(cloud);
    bdExp = new BDValidationExpression(cloud);
    cdAltExp = new CDAltValidationExpression(cloud);
    ddAltExp = new DDAltValidationExpression(cloud);

    dcExp = new DCValidationExpression(cloud);
    dAltbExp = new DAltBValidationExpression(cloud);
  }

  @override
  Future<Null> ngOnInit() async {}

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
  }
}
