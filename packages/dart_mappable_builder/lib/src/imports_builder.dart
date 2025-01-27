import 'package:build/build.dart';
import 'package:path/path.dart' as p;

final path = p.posix;

class ImportsBuilder {
  final Set<Uri> _imports = {};
  final AssetId _input;

  ImportsBuilder(this._input) {
    _imports.add(Uri.parse('package:dart_mappable/dart_mappable.dart'));
    _imports.add(Uri.parse('package:dart_mappable/internals.dart'));
  }

  void add(Uri import) {
    if (import.scheme == 'package' &&
        import.pathSegments.first == 'dart_mappable') {
      return;
    }
    _imports.add(import);
  }

  void addAll(Iterable<Uri> imports) => imports.forEach(add);

  String write() {
    List<String> sdk = [], package = [], relative = [];

    for (var import in _imports) {
      if (import.isScheme('asset')) {
        var relativePath =
            path.relative(import.path, from: path.dirname(_input.uri.path));

        relative.add(relativePath);
      } else if (import.isScheme('package') &&
          import.pathSegments.first == _input.package &&
          _input.pathSegments.first == 'lib') {
        var libPath =
            import.replace(pathSegments: import.pathSegments.skip(1)).path;

        var inputPath = _input.uri
            .replace(pathSegments: _input.uri.pathSegments.skip(1))
            .path;

        var relativePath =
            path.relative(libPath, from: path.dirname(inputPath));

        relative.add(relativePath);
      } else if (import.scheme == 'dart') {
        sdk.add(import.toString());
      } else if (import.scheme == 'package') {
        package.add(import.toString());
      } else {
        relative.add(import.toString()); // TODO: is this correct?
      }
    }

    sdk.sort();
    package.sort();
    relative.sort();

    String joined(List<String> s) =>
        s.isNotEmpty ? '${s.map((s) => "import '$s';").join('\n')}\n\n' : '';
    return joined(sdk) + joined(package) + joined(relative);
  }
}
