import React from 'react';
import {Image, StyleSheet, Text, TouchableOpacity, View} from 'react-native';

const tomProfilePicture =
  'https://images.unsplash.com/photo-1569591159212-b02ea8a9f239?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzN8fGNhdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60';

export default function Profile() {
  return (
    <View style={styles.container}>
      <TouchableOpacity style={styles.profilePictureTouchable}>
        <Image src={tomProfilePicture} style={styles.profilePicture} />
        <View style={styles.profilePictureEdit}>
          <Text style={styles.profilePictureEditText}>Edit</Text>
        </View>
      </TouchableOpacity>
      <Text style={styles.text}>Tom</Text>

      <View style={styles.stats}>
        <View style={styles.stat}>
          <Text style={styles.statNumber}>15</Text>
          <Text>Games</Text>
        </View>

        <View style={styles.stat}>
          <Text style={styles.statNumber}>9</Text>
          <Text>Wins</Text>
        </View>

        <View style={styles.stat}>
          <Text style={styles.statNumber}>343</Text>
          <Text>Points</Text>
        </View>
      </View>

      <View style={styles.buttons}>
        <TouchableOpacity style={styles.button}>
          <Text style={styles.buttonText}>Change Name</Text>
        </TouchableOpacity>
        <TouchableOpacity style={[styles.button, styles.buttonDeleteProfile]}>
          <Text style={styles.buttonText}>Delete Profile</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
  },
  profilePictureTouchable: {
    width: 100,
    height: 100,
    borderRadius: 50,
    marginTop: 20,
    overflow: 'hidden',
    position: 'relative',
  },
  profilePicture: {
    width: '100%',
    height: '100%',
  },
  profilePictureEdit: {
    position: 'absolute',
    bottom: 0,
    width: '100%',
    height: '22%',
    backgroundColor: 'rgba(0, 0, 0, 0.55)',
    alignItems: 'center',
    paddingTop: 2,
  },
  profilePictureEditText: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '300',
    textTransform: 'uppercase',
  },
  text: {
    fontSize: 32,
    marginTop: 10,
    fontWeight: '700',
  },
  stats: {
    flexDirection: 'row',
    justifyContent: 'center',
    marginTop: 20,
  },
  stat: {
    flexBasis: '30%',
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 20,
    fontWeight: '600',
    marginBottom: 4,
  },
  buttons: {
    marginTop: 35,
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
  },
  button: {
    backgroundColor: '#1829e5',
    margin: 5,
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
  },
  buttonDeleteProfile: {
    backgroundColor: '#831133',
  },
  buttonText: {
    color: '#FFFFFF',
    fontWeight: '700',
  },
});
