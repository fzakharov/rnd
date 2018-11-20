import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:dartang/src/model/Entity.dart';

@Component(
  selector: 'validation-expression',
  styleUrls: ['validation_expression_component.css'],
  templateUrl: 'validation_expression_component.html',
  directives: [
    materialInputDirectives,
    NgFor,
  ],
)
class ValidationExpressionComponent {
  ValidationExpressionComponent();

  @Input()
  ValidationExpression validationExpression;
}
