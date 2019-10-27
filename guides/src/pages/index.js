// --- Dependencies
import * as React from 'react'

// --- Components
import Layout from 'components/Layout'
import Section from 'components/Section'

/**
 * Component
 */

const IndexPage = () => (
  <Layout
    pathname="/"
    title="Home"
    description="Viauco Commerce API, documentation, guides & tutorials"
  >
    <div className="center mw9 ph4 mt5">
      <p className="lh-copy f3 tc mw7 center mb5">
        <a href="https://viaucocommerce.org" className="viauco-blue fw6">
          Viauco Commerce
        </a>
        &nbsp;is a complete modular, API-driven open source e-commerce solution
        &nbsp;built with Ruby on Rails
      </p>

      <div className="mw8 center">
        <div className="flex flex-column flex-wrap flex-row-ns mv4 w-100">
          <Section path="/api/overview" title="API Guides">
            The REST API is designed to give developers a convenient way to
            access data contained within Viauco. With a standard read/write
            interface to store data, it is now very simple to write third party
            applications (JavaScript/Mobile/other technologies) that can talk to
            your Viauco store.
          </Section>

          <Section path="/developer" title="Developer Guides">
            This part of Viauco’s documentation covers the technical aspects of
            Viauco. If you are working with Rails and are building a Viauco store,
            this is the documentation for you.
          </Section>

          <Section path="/user" title="User Guides">
            This documentation is intended for business owners and site
            administrators of Viauco e-commerce sites. Everything you need to
            know to configure and manage your Viauco store can be found here.
          </Section>

          <Section path="/release_notes" title="Release Notes">
            Each major new release of Viauco has an accompanying set of release
            notes. The purpose of these notes is to provide a high level
            overview of what has changed since the previous version of Viauco.
          </Section>
        </div>
      </div>
    </div>
  </Layout>
)

export default IndexPage
