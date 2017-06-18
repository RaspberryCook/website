class Recipe extends React.Component {
  render() {
    return <div className="col-md-3 col-sm-4 col-xs-6">
      <figure className="recipe" >
        <a href={this.props.url}>
          <img src={this.props.imageUrl} className='img-responsive img-rounded' alt="Image for {this.props.name}" />
        </a>
        <figcaption>
          <a href={this.props.url}>{this.props.name}</a>
        </figcaption>
  		</figure>
    </div>
  }
}
