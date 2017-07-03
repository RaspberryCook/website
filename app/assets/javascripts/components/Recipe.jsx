class Recipe extends React.Component {

  constructor(props){
    super(props);
    this.state = {isHovered: false};
    // declare event here
    this.handleHover = this.handleHover.bind(this);
  }

  handleHover(){
    this.setState({
      isHovered: !this.state.isHovered
    });
  }

  render() {
    if(this.state.isHovered){
      return (
        <div
        className="col-md-3 col-sm-4 col-xs-6"
        onMouseEnter={this.handleHover}
        onMouseLeave={this.handleHover}
        >
          <figure className="recipe" >
            <ul>
              <li>{this.props.ingredients}</li>
            </ul>
            <figcaption>
              <a href={this.props.url}>{this.props.name}</a>
            </figcaption>
          </figure>
        </div>
      )

    }else{
      return (
        <div
        className="col-md-3 col-sm-4 col-xs-6"
        onMouseEnter={(this.handleHover)}
        >
          <div className="thumbnail recipe">
            <img src={this.props.imageUrl} className='img-responsive img-rounded' alt="Image for {this.props.name}" />
            <div className="caption">
              <h3><a href={this.props.url}>{this.props.name}</a></h3>
              <p>
              </p>
            </div>
          </div>
        </div>
      )
    }
  }
}
