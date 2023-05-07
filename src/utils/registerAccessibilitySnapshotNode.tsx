import {AppRegistry, NativeModules} from 'react-native';

export default function registerAccessibilitySnapshotNode(
  name: string,
  node: JSX.Element,
  width = 300,
  height = 700,
) {
  AppRegistry.registerComponent(name, () => () => node);
  const {SnapshotTests} = NativeModules;
  if (!SnapshotTests) {
    return;
  }

  const result = SnapshotTests.register(name, width, height);
  if (!result) {
    throw new Error(`Couldn't register ${name}`);
  }
}
