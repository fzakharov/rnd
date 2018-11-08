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
  LogicalEntity a;
  LogicalEntity b;
  LogicalEntity c;
  LogicalEntity d;
  LogicalEntity dAlt;
  LinkLogicalEntity ab;
  LinkLogicalEntity ac;
  LinkLogicalEntity bd;
  LinkLogicalEntity cdAlt;

  EvaporatingCloudComponent() {
    a = new LogicalEntity();
    b = new LogicalEntity();
    c = new LogicalEntity();
    d = new LogicalEntity();
    dAlt = new LogicalEntity();
    ab = new LinkLogicalEntity(a, b);
    ac = new LinkLogicalEntity(a, c);
    bd = new LinkLogicalEntity(b, d);
    cdAlt = new LinkLogicalEntity(c, dAlt);

    ac.expression =
        bd.expression = cdAlt.expression = ab.expression = "мы должны";
  }

  String Title = 'no';

  @override
  Future<Null> ngOnInit() async {}

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    // TODO: implement ngOnChanges
  }
}
