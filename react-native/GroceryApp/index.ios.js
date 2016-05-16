/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

'use strict';

const React = require('react-native');
const Firebase = require('firebase');
const StatusBar = require('./components/StatusBar');
const ActionButton = require('./components/ActionButton');
const ListItem = require('./components/ListItem');
const styles = require('./styles.js');

const {
 AppRegistry,
 ListView,
 StyleSheet,
 Text,
 View,
 TouchableHighlight,
 AlertIOS
} = React;


class GroceryApp extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      dataSource: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2
      })
    };

    this.itemsRef = new Firebase('https://bikeshed.firebaseio.com/items');
  }

  listenForItems(itemsRef) {
    itemsRef.on('value', (snap) => {
      // get children as an array
      var items = [];
      snap.forEach((child) => {
        items.push({
          title: child.val().title,
          _key: child.key()
        });
      });
      this.setState({
        dataSource: this.state.dataSource.cloneWithRows(items)
      });
    });
  }

  _addItem() {
    AlertIOS.prompt(
      'Add new item',
      null,
      [{
        text: 'Add',
        onPress: (text) => {
          this.itemsRef.push({title: text});
        }
      }],
      'plain-text'
    );
  }

  componentDidMount() {
    this.listenForItems(this.itemsRef);
  }

  _renderItem(item) {
    const onPress = () => AlertIOS.prompt('Complete', null, [
      {text: 'Complete', onPress: (text) => this.itemsRef.child(item._key).remove()},
      {text: 'Cancel', onPress: (text) => console.log('Cancel')}
    ], 'default');
    return (
      <ListItem item={item} onPress={onPress} />
   );
  }

  render() {
    return (
      <View style={styles.container}>
        <StatusBar title="Grocery List" />
        <ListView
          dataSource={this.state.dataSource}
          renderRow={this._renderItem.bind(this)}
          style={styles.listview}/>
        <ActionButton title="Add" onPress={this._addItem.bind(this)} />
      </View>
    );
  }
}

AppRegistry.registerComponent('GroceryApp', () => GroceryApp);
