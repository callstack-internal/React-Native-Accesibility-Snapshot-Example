import {AppRegistry, NativeModules} from 'react-native';

export default function registerAccessibilitySnapshotNode(
  name: string,
  node: JSX.Element,
) {
  AppRegistry.registerComponent(name, () => () => node);
  const {SnapshotTests} = NativeModules;
  if (!SnapshotTests) {
    return;
  }

  const result = SnapshotTests.registerName(name);
  if (!result) {
    throw new Error(`Couldn't register ${name}`);
  }
}
