class Star extends React.Component {
  render(){
    return(
      <img
        height="40"
        width="40"
        alt="Etoile"
        src={this.props.src}
      />
    )
  }
}
